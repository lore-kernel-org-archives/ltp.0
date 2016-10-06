From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 Oct 2016 14:35:29 +0200
Subject: [LTP] [PATCH] lib: add tst_res_hexd for newlib
In-Reply-To: <77e055a73816d095647ced78f9444932845f370c.1475754253.git.jstancek@redhat.com>
References: <77e055a73816d095647ced78f9444932845f370c.1475754253.git.jstancek@redhat.com>
Message-ID: <20161006123528.GA10467@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Locking mutex isn't necessary for oldlib, because
> we already lock at tst_res__ level.

Well, technically that would mean that the lines from hexdump may be
interleaved with other messages but in reality I doubt that this would
ever happen.

We should propably add a note to test-writing-guidelines, apart from
that this looks OK. Acked.

-- 
Cyril Hrubis
chrubis@suse.cz
