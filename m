From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 9 Nov 2020 21:48:34 +0300
Subject: [LTP] [PATCH v2] tcp_cmds/ping/ping02: Make it compatible with
 Busybox
In-Reply-To: <20201109192753.70167ef1@kmaincent-XPS-13-7390>
References: <20201106143605.27230-1-kory.maincent@bootlin.com>
 <5de346c3-ccd6-743e-c83c-e16c592c7ac5@oracle.com>
 <20201109192753.70167ef1@kmaincent-XPS-13-7390>
Message-ID: <3dd5d20c-5dd9-7877-997b-731018e4d0ec@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09.11.2020 21:27, K?ry Maincent wrote:
>>
>> $PING -h 2>&1 | grep -q '[-]f' || ping_opts="-i 0.01 -p aa"
> 
> The grep in parameter is not working for all cases.
> For example the ping usage of my Ubuntu laptop is:
> Usage: ping [-aAbBdDfhLnOqrRUvV64] [-c count] [-i interval] [-I interface]
>             [-m mark] [-M pmtudisc_option] [-l preload] [-p pattern] [-Q tos]
>             [-s packetsize] [-S sndbuf] [-t ttl] [-T timestamp_option]
>             [-w deadline] [-W timeout] [hop1 ...] destination
> 
> 
> I may use test like this:
> $PING -c 1 -f $ipaddr >/dev/null 2>&1 || ping_opts="-i 0.01 -p aa"
> 
> What do you think?
> 

Agree, in that case it's better to try ping with the option.
