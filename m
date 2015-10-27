From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 27 Oct 2015 15:32:47 +0800
Subject: [LTP]  How about set IPsec with ip xfrm?
Message-ID: <CAPwn2JRO0Dx20LzBHrLhMb85EoU9+_WRnRTS5UO2sQ9Ej3y+Cw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril and Alexey,

Msst of the network stress tests have IPsec testing, and
we use setkey for configuration. But setkey[1] hasn't updated
for a long time. And some distros, RHEL7 for example, even
don't have ipset-tools package. So how about rewrite IPsec
config with ip xfrm? or at least make both method works?

[1] http://ipsec-tools.sourceforge.net/

Thanks
Hangbin Liu
