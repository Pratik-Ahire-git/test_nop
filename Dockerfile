FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
RUN git clone "https://github.com/Pratik-Ahire/nopCommerce.git"
RUN cd nopCommerce && mkdir published
RUN dotnet publish -c Release -o published/ src/Presentation/Nop.Web/Nop.Web.csproj
RUN cd published
RUN mkdir bin && mkdir logs

FROM mcr.microsoft.com/dotnet/aspnet:8.0
USER nobody
COPY --from=build --chown=nobody published/ /nop/published
EXPOSE 5000
CMD ["dotnet", "Nop.Web.dll", "--urls", "http://0.0.0.0:5000"]