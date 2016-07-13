From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Jul 2016 16:23:33 +0200
Subject: [LTP] [PATCH] lib: add tst_read_meminfo / tst_get_avail_mem
In-Reply-To: <937821381.4475496.1468419193289.JavaMail.zimbra@redhat.com>
References: <cad01181438a055f45b32fc28b33a8b8da74b768.1465903335.git.jstancek@redhat.com>
 <1589618283.6491776.1465976075619.JavaMail.zimbra@redhat.com>
 <57614F55.9090407@redhat.com> <20160616052544.GA18852@gmail.com>
 <1809783770.6955910.1466060898915.JavaMail.zimbra@redhat.com>
 <20160713093505.GA6033@gmail.com> <57863E28.7020309@redhat.com>
 <20160713135428.GD2232@rei.scz.novell.com>
 <937821381.4475496.1468419193289.JavaMail.zimbra@redhat.com>
Message-ID: <20160713142332.GE2232@rei.scz.novell.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > It's similar to SAFE_FILE_SCANF, but it scanfs each line and first
> > > matching all scanf directives wins and terminates search, otherwise
> > > you get non-zero ret code. For example:
> > > 
> > > if (SAFE_FILE_LINES_SCANF("/proc/meminfo", "MemFree: %ld", &free))
> > >         tst_brk(TBROK, "Could not parse MemFree");
> > 
> > The API looks good to me. Nice work.
> > 
> > We should call this version FILE_LINES_SCANF() since the SAFE_ variants
> > call tst_brkm() on failure.
> 
> I was hesitant about SAFE_ part, but since it still calls brk on some
> occasions I left it there.
> 
> There is also option to remove brkm calls, turn it into tst_file_lines_scanf(),
> and let user deal with possible errors.

Thinking about this, there are only two errors that we care about.
Either the file we are trying to open does not exist, which may be
reason to fail the test with TCONF instead or use different code path.
And the second one is when we couldn't match the line(s) which has the
same implications.

We can safely call tst_brkm(TBROK,) for the rest of the cases. And even
the 'file does not exist' could be easily handled in test setup with
single access() call.

So I would say that we can keep the code as it is and just drop the
SAFE_ prefix and possibly add SAFE_FILE_LINES_SCANF() as well for cases
where the user is not interested in handling the returned error himself.

-- 
Cyril Hrubis
chrubis@suse.cz
