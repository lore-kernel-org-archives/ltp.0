From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Jun 2019 11:58:05 +0200
Subject: [LTP] [PATCH v4] syscalls/sync_file_range: add partial file
 sync test-cases
In-Reply-To: <CAOQ4uxithmPn6J=B2kaGKT0JOpqzyVEkHU+zMqhXCYnnH+ZHVQ@mail.gmail.com>
References: <1560161596-30156-1-git-send-email-sumit.garg@linaro.org>
 <20190617150640.GD16831@rei>
 <CAOQ4uxithmPn6J=B2kaGKT0JOpqzyVEkHU+zMqhXCYnnH+ZHVQ@mail.gmail.com>
Message-ID: <20190619095805.GC16577@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > With these modification the test was stable and worked fine for more
> > than 100 iterations for me. It still fails for FUSE based filesystems
> > but that is to be expected since FUSE does not implement sync_file_range
> > yet.
> >
> 
> What is the proposed way to resolve this failure?
> If FUSE does not implement sync_file_range, shouldn't test detect
> it and return TCONF?

Well the call returns success but does not sync anything on FUSE based
filesystems so the choices here are:

1) Disable the test of FUSE
2) Keep the test failing and ignore the failures

Which one do you prefer?

-- 
Cyril Hrubis
chrubis@suse.cz
