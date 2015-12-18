From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 18 Dec 2015 17:35:28 +0300
Subject: [LTP] pi_test: support more CPU configurations
Message-ID: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

It was found that pi_test test cases do not work correctly
in environments with a large number of CPUs and/or where some
of them are disabled.

This series aims to fix that.

Tested in ldoms, on a T7-4 and a couple x86 desktop machines.

Thanks.

