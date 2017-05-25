#!/usr/bin/python3
import socket
from http.server import HTTPServer, SimpleHTTPRequestHandler
import argparse
import os

class MyHandler(SimpleHTTPRequestHandler):
  def do_GET(self):
    if self.path == '/ip':
      self.send_response(200)
      self.send_header('Content-type', 'text/html')
      self.end_headers()
      self.wfile.write('ip adresiniz %s' % self.client_address[0])
      return
    else:
      return SimpleHTTPRequestHandler.do_GET(self)

class HTTPServerV6(HTTPServer):
  address_family = socket.AF_INET6

def main():
  suankiyer=os.getcwd()
  parser = argparse.ArgumentParser(description='yerel pratik sunucu')
  parser.add_argument('-p', '--port', help='calisma portu', type=int, default=9000)
  parser.add_argument('-d', '--directory', help='calisma dizini', type=str,default=suankiyer)
  args = parser.parse_args()
  print ("çalışma dizini: ",args.directory)
  os.chdir(args.directory)
  server = HTTPServerV6(('::', args.port), MyHandler)
  server.serve_forever()

if __name__ == '__main__':
	main()
