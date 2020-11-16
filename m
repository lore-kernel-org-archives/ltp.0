From: =?unknown-8bit?q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>
Date: Mon, 16 Nov 2020 09:33:39 +0100
Subject: [LTP] Need support on host01 test command.
In-Reply-To: <509d120d-35b5-d435-c052-4d34314dd438@oracle.com>
References: <20201113161739.37034d68@kmaincent-XPS-13-7390>
 <509d120d-35b5-d435-c052-4d34314dd438@oracle.com>
Message-ID: <20201116093339.46687d76@kmaincent-XPS-13-7390>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Alexey,

On Fri, 13 Nov 2020 19:22:39 +0300
Alexey Kodanev <alexey.kodanev@oracle.com> wrote:

> On 13.11.2020 18:17, K?ry Maincent wrote:
> > Hello,
> > 
> > I am trying to update host01 test to the new API, but I got some problem
> > with that task.
> > 
> > I am not a network expert and I am wondering why I got this issue:
> > # host $(hostname)
> > ;; connection timed out; no servers could be reached
> > # host localchost
> > ;; connection timed out; no servers could be reached
> > 
> > 
> > I am working on an embedded board with an OpenEmbedded based distribution.
> > I may miss some network package, could you give me a hint to go further.
> >   
> 
> Hi Kory,
> 
> Either you don't have /etc/resolv.conf or it is empty.

Ok, thank you for pointing me out the cause.
In fact, the file exist and is linked to /run/systemd/resolve/resolv.conf but
my issue was if nothing is plugged on the ethernet port it is not working. 

Regards,

-- 
K?ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
