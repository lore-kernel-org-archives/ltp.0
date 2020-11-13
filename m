From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 13 Nov 2020 19:22:39 +0300
Subject: [LTP] Need support on host01 test command.
In-Reply-To: <20201113161739.37034d68@kmaincent-XPS-13-7390>
References: <20201113161739.37034d68@kmaincent-XPS-13-7390>
Message-ID: <509d120d-35b5-d435-c052-4d34314dd438@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 13.11.2020 18:17, K?ry Maincent wrote:
> Hello,
> 
> I am trying to update host01 test to the new API, but I got some problem with
> that task.
> 
> I am not a network expert and I am wondering why I got this issue:
> # host $(hostname)
> ;; connection timed out; no servers could be reached
> # host localchost
> ;; connection timed out; no servers could be reached
> 
> 
> I am working on an embedded board with an OpenEmbedded based distribution.
> I may miss some network package, could you give me a hint to go further.
> 

Hi Kory,

Either you don't have /etc/resolv.conf or it is empty.



