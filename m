From: =?unknown-8bit?q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>
Date: Fri, 13 Nov 2020 16:17:39 +0100
Subject: [LTP] Need support on host01 test command.
Message-ID: <20201113161739.37034d68@kmaincent-XPS-13-7390>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

I am trying to update host01 test to the new API, but I got some problem with
that task.

I am not a network expert and I am wondering why I got this issue:
# host $(hostname)
;; connection timed out; no servers could be reached
# host localchost
;; connection timed out; no servers could be reached


I am working on an embedded board with an OpenEmbedded based distribution.
I may miss some network package, could you give me a hint to go further.

Regards,

-- 
K?ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
