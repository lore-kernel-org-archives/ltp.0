From: Steve Ellcey <sellcey@caviumnetworks.com>
Date: Tue, 07 Mar 2017 10:40:47 -0800
Subject: [LTP] Running LTP results in read-only filesystem
Message-ID: <1488912047.22552.6.camel@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Has anyone run into a problem where running the LTP tests as root
results in a read-only filesystem?  I have been running LTP as root on
an ubuntu 16.04 aarch64 system and it appears that when I do that my
root filesystem gets set to read-only and then, when I reboot to try
and fix the problem, the machine can't fsck itself and come back up
without some human intervention.  Has anyone else seen this problem?

Steve Ellcey
sellcey@cavium.com
