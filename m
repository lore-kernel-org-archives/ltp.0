From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 1 Dec 2020 15:37:48 +0100
Subject: [LTP] linux kernel versions vs. ltp release tags
In-Reply-To: <CAPeFc=Rvpq90yQKaGfg9gtFhyJNui3CvjY4ewOy6DS2na9RXNQ@mail.gmail.com>
References: <CAPeFc=TgA6ABrvDthLBoruqfmopx5nhqYYDAv7h0B+CjaFY-CA@mail.gmail.com>
 <20201201125542.GB27684@yuki.lan>
 <CAPeFc=Rvpq90yQKaGfg9gtFhyJNui3CvjY4ewOy6DS2na9RXNQ@mail.gmail.com>
Message-ID: <20201201143748.GA3405@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> thanks for the answer. In my particular case there is a test
> https://github.com/linux-test-project/ltp/blob/b59c662104c8989704953d1e5dc8c3c6412daa2a/testcases/kernel/syscalls/sendto/sendto03.c
> which causes kernel panic because it tests something which is not present
> in my kernel.
> Are there any recommendations on what to do in such a case?

Well the test in question is a regression test for a security
vunerability. If the test causes kernel panic that most likely means
that your kernel is vunerable and is missing the patch that that is
mentioned in the top level test commit.

-- 
Cyril Hrubis
chrubis@suse.cz
