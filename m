From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Sep 2017 10:34:28 +0200
Subject: [LTP] [RFC] [PATCH 01/15] lib/tst_mkfs: Clear first 512k of the
 device
In-Reply-To: <1786606525.10020364.1504770171451.JavaMail.zimbra@redhat.com>
References: <20170905160918.6477-1-chrubis@suse.cz>
 <1786606525.10020364.1504770171451.JavaMail.zimbra@redhat.com>
Message-ID: <20170907083428.GA32577@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > If we cal tst_mkfs() from a test more than once we end up with the very
> > same bug we already fixed by clearing the device in
> > tst_acquire_device(), i.e. some mkfs programs will not format it when
> > there is a valid FS signature there.
> > 
> > So this commit moves the code to clear up the first 512k of the device
> > from tst_acquire_device() to the tst_mkfs() where it rightfully belongs.
> 
> Didn't we move the clearing to tst_acquire_device() because of shell library
> some time ago? tst_mkfs() from tst_test.sh is not using tst_mkfs_().

Right, the shell mkfs test would fail in a case that we have a device
passed via LTP_DEV because the start of the device wouldn't be cleaned
at all.

I guess that the easiest solution would be leaving the code to clear the
start of the device in the acquire_device() as well. We would end up
clearing it twice in some situations though.

-- 
Cyril Hrubis
chrubis@suse.cz
