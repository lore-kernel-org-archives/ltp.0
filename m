From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 8 Jun 2016 08:41:07 -0400 (EDT)
Subject: [LTP] futex_wake04 failure on 4.6, patch posted on lkml
In-Reply-To: <393533224.4592029.1465389364414.JavaMail.zimbra@redhat.com>
Message-ID: <1759788272.4593308.1465389667101.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I came across this failure yesterday, and after I finished
bisect I found that a patch has already been posted in the meantime:
  [PATCH] futex: Calculate the futex key based on a tail page for file-based futexes
  https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1161074.html

Regards,
Jan
