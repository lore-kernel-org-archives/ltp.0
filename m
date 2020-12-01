From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 1 Dec 2020 13:55:42 +0100
Subject: [LTP] linux kernel versions vs. ltp release tags
In-Reply-To: <CAPeFc=TgA6ABrvDthLBoruqfmopx5nhqYYDAv7h0B+CjaFY-CA@mail.gmail.com>
References: <CAPeFc=TgA6ABrvDthLBoruqfmopx5nhqYYDAv7h0B+CjaFY-CA@mail.gmail.com>
Message-ID: <20201201125542.GB27684@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I would like to test linux with kernel version 5.4.47.
> Is there any relation between ltp releases and kernel versions?

Short answer: No.

More detailed answer:

LTP should be backwards compatible for about 10 years back for both
kernel and userspace (libc, gcc, etc.). I.e. latest should run fine on
10 years old distribution and anything newer. Latest LTP also contains
more testcases and fixes so in 99% of the cases it makes senes to use
either latest stable release or a git HEAD.

-- 
Cyril Hrubis
chrubis@suse.cz
