#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

FROM microsoft/dotnet:2.1-sdk
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.1-sdk
WORKDIR /src
COPY ["./WebApplication1testdekl/WebApplication1testdekl.csproj", "WebApplication1testdekl/"]
RUN dotnet restore "WebApplication1testdekl/WebApplication1testdekl.csproj"
COPY . .
WORKDIR "/src/WebApplication1testdekl"
RUN dotnet build "WebApplication1testdekl.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "WebApplication1testdekl.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "WebApplication1testdekl.dll"]