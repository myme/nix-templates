# A basic Go template

## Setup

```sh
$ nix flake new -t github:myme/nix-templates#go hello-go
$ cd hello-go
$ go mod init example/hello
```

## Create a hello module

```go
package main

func main() {
    fmt.Println("Hello, World!")
}
```

## Run it

```sh
go run .
```
