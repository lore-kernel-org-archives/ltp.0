From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 18 Jan 2017 13:45:20 +0300
Subject: [LTP] FYI: networking: broken multicast test due upstream bug
In-Reply-To: <20170118083100.myaindbkf2nsoqp2@dell5510>
References: <20170118083100.myaindbkf2nsoqp2@dell5510>
Message-ID: <d244f109-d08e-d3d9-7a4c-79610a7cde33@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 01/18/2017 11:31 AM, Petr Vorel wrote:
> Hi,
>
> mc_cmds test (runtest net.multicast, LTP networking) is broken when running with network
> namespaces due upstream bug in ip (see https://bugzilla.kernel.org/show_bug.cgi?id=192741).
> In our case 'ip maddr show ltp_ns_veth2' does not return 'inet  224.0.0.1'.
>
> It has been fixed in master, but it will not work with old distros. I suppose we leave it as it is (don't fix it with any workaround).

Thanks! May be we should workaround it as it will be skipped without 
doing anything on most distros.

I see two options:
* parse 'ip maddr show' without dev as a workaround if the first attempt 
fails, or
* parse /proc/net/igmp, looking for 0x010000E0 (1.0.0.224).

Best regards,
Alexey

