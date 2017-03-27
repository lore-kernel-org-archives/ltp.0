From: Steve Ellcey <sellcey@cavium.com>
Date: Mon, 27 Mar 2017 15:18:51 -0700
Subject: [LTP] Failing tests (aio01/aio02) show up in log file but not
	failed list
Message-ID: <201703272218.v2RMIp4R006418@sellcey-dt.caveonetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


I noticed an odd thing when running LTP.  There are two tests that
show up as FAIL in my results/LTP*.log file (aio01 and aio02) but are
not listed in the LTP*.failed list in the output directory.

Does anyone know why these tests don't get listed?  All my other
failures show up in both places.
