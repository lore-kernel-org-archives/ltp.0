From: Yan Kun <samyankun@gmail.com>
Date: Fri, 2 Dec 2016 12:36:02 +0800
Subject: [LTP] about libipc
Message-ID: <CAJ5Dnr1XF-jzn7FYfJZGXJjdMUjhma6TPnu5ApzY6euOAH-33w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,All

In our current libipc,it will use shmctl and shmget to operate a piece of
share memory,but android has a different implement of share memory .So how
about to add support for ashmem(Android share memory)?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161202/4a95abf7/attachment-0001.html>
