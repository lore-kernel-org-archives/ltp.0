From: Cixi Geng <gengcixi@gmail.com>
Date: Fri, 21 Aug 2020 10:29:49 +0800
Subject: [LTP] [RFC] ltp test add reboot function
Message-ID: <CAF12kFuE=4-T=eitwSb0F3fkGLLsmM3VEg4VNbioqJt2JiAEww@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi ALL:

I want to add a reboot function in LTP for my team write a memory page
related case?
and need reboot to make the memory cache or some likely it pure clear.

So I want to add a tst_needs_reboot. when it was set, reboot the
machine and continue
run test from the point before.

I think  this requirement is meaningful? So can you give me some advise?
