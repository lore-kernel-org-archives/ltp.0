From: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Date: Tue, 15 Mar 2016 10:52:44 +0000
Subject: [LTP] [PATCH] mmap2: change memory units to MB to support embedded
	devices
Message-ID: <AF04265A3FC2B144B9892F621A394E13EA3E89AB@tethys>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

This patch made two changes:

1) check the available memory before to perform the test case
2) change the memory units from GB to MB.

Both changes are needed during testing on embedded devices with RAM memory limitation (i.e. 512MB).

This patch no changed the test case procedure and the default memory size is the same (1GB=1000MB).

To use this test case in embedded devices, I suggest to change the testrun 'mm' as below

- mtest06_2 mmap2 -x 0.002 -a -p
+ mtest06_2 mmap2 -x 0.002 -a -p -s 100

This patch come from previous discussion at http://lists.linux.it/pipermail/ltp/2016-March/001233.html

Regards

Julio

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160315/3a1ecfde/attachment.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Change-memory-units-to-MB-to-support-embedded-device.patch
Type: application/octet-stream
Size: 4734 bytes
Desc: 0001-Change-memory-units-to-MB-to-support-embedded-device.patch
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160315/3a1ecfde/attachment.obj>
