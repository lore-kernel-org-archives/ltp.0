From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Sep 2020 17:36:59 +0200
Subject: [LTP] [PATCH] syscalls/ptrace10: Add new regression test
In-Reply-To: <6d9b6e46-8337-9614-8fd7-b6ada8fcbe13@suse.cz>
References: <20200904180030.14838-1-chrubis@suse.cz>
 <6d9b6e46-8337-9614-8fd7-b6ada8fcbe13@suse.cz>
Message-ID: <20200911153659.GA7234@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> the code looks good, though it might make sense to simply integrate the
> check into ptrace08. Just 6 extra lines in the existing test should
> achieve the same coverage.

I would like to avoid triggering the "your system may be vunerable"
messages on fixed kernel, hence the separate test.

-- 
Cyril Hrubis
chrubis@suse.cz
