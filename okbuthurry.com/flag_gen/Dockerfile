
FROM microsoft/dotnet:sdk AS build-env
WORKDIR /app

RUN git clone https://github.com/busyDuckman/FlagGenService.git && \
    git clone https://github.com/busyDuckman/WDLibCore

RUN cd FlagGenService && \
    dotnet restore

RUN RUN dotnet publish -c Release -o out
# Copy csproj and restore as distinct layers
# COPY *.csproj ./


# Copy everything else and build
# COPY . ./
# RUN dotnet publish -c Release -o out



# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "aspnetapp.dll"]