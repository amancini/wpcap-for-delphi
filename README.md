# wpcap-for-delphi
The wpcap.wrapper Delphi package provides a wrapper for the WinPcap (wpcap) library, which is a low-level packet capture library for Windows.

![image](https://user-images.githubusercontent.com/11525545/219884447-c06aa71f-17cf-47e2-9304-8a3eb7126f2a.png)


The package contains several units including: 

+ **wpcap.Wrapper.pas:**  which wraps the functions of the wpcap DLL.
+ **wpcap.Conts.pas:**   which contains constants used in the library. 
+ **wpcap.Types.pas:**    which contains structures used by the library. 
+ **wpcap.Protocol.pas:** which contains functions for managing protocols.
+ **wpcap.StrUtils.pas:** which contains string manipulation functions.
+ **wpcap.IOUtils.pas:**  which contains functions for filesystem.
+ **wpcap.Pcap.pas:**  which contains abstract function for load and save PCAP.
+ **wpcap.PCAP.SQLite.pas:**  which contains abstract function for create SQLiteDB with packet of PCAP.
+ **wpcap.DB.Base:**  which contains base class for managing database.
+ **wpcap.DB.SQLite.pas:**  which contains function SQLiteDB.
+ **wpcap.Filter.pas:**  which contains function for filter PCAP.
+ **wpcap.NetDevice:**  which contains function for managing network inteface.
+ **wpcap.Protocol.Base:**  which contains base class engine for protocol detection
+ **wpcap.Graphics:**  which contains function for colors


It enables the capture and analysis of network packets, making it useful for a wide range of applications, including network analysis, security testing, and network monitoring.

# DEMO

The demo project uses DevExpress libraries


# TODO LIST

+ Thread with syncronize
+ Aborto loading
+ Query bulder 
+ Packet detail 
+ TcpFlow 
+ UdpFlow
+ Port for TCP protocol
+ Realtime capture 
+ geoIp with map

# TODO LIST FOR DEMO
+ ChartStatistics by protocol
+ Grid with port TCP




