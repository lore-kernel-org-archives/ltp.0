From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Jun 2016 16:45:16 +0200
Subject: [LTP] [PATCH] network/perf_lan: remove the test
In-Reply-To: <1465571138-28420-1-git-send-email-alexey.kodanev@oracle.com>
References: <1465571138-28420-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160622144516.GI13962@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> * Test does what 'ping -p' command can do (can be added to tcp_cmds/ping);
> * It needs cleanup/fixing and IPv6 version is disabled right now;
> * ck_packet() is wrongly setting data buffer pointer, assuming that
>   the sender added timestamp but it didn't. Actually timestamp was
>   removed in the packet sending code but not in the receiving one
>   (patch ef77253);
> * Also test always passes, even if packet data is not correct, because
>   ck_packet() always returns 0, so it doesn't really check packets.

The test really seems to be recreating in C what could be done with ping
albeit it seems to send count packets as fast as possible, as far as I
can tell it does someting equivalent to:

"ping -c $count -f -s $packetsize -p 00010203..."

Also looking closer the $count is wired to 1, so the -f does not have
any effect.

I guess that the ping01 covers more or less the same and adding more
functionality to it is much easier than fixing the mess called perf_lan.

In short, the removal is acked.

-- 
Cyril Hrubis
chrubis@suse.cz
