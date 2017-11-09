From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Nov 2017 11:50:53 +0100
Subject: [LTP] [PATCH v3 15/16] fs/fs_fill: Add a test to fill a FS in a
 few threads
In-Reply-To: <CAEemH2eNcwa6FpnEHVBtTp=rBFCVwrGBO6sZ9=P1m5hRb=zRDQ@mail.gmail.com>
References: <20171011144130.29728-1-chrubis@suse.cz>
 <20171011144130.29728-15-chrubis@suse.cz>
 <CAEemH2f8Dya2XUvZZ2t9XMbbVFo_tM5B=LuzjZqyB8ZCA6qvVA@mail.gmail.com>
 <20171109101915.GA7738@rei>
 <CAEemH2eNcwa6FpnEHVBtTp=rBFCVwrGBO6sZ9=P1m5hRb=zRDQ@mail.gmail.com>
Message-ID: <20171109105053.GB7738@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The correct fix is to use open() instead of SAFE_OPEN() in the
> > tst_fill_fs() and just return from the function when we get ENOSPC. I
> > can fix that, or you can send the patch. Either way thanks for pointing
> > out the mistake.
> 
> The broken are not only in tst_fills_fs() function but also come from
> SAFE_MKDIR(w->dir, 0700),

Ok, we have to create the directories in the testrun() function before
we attempt to run the threads, that should fix this particular problem.

> SAFE_OPENDIR(w->dir) and SAFE_UNLINK(file).

The opendir() should not fail with ENOSPC since that only reads the
directory content.

And the unlink() should not fail with ENOSPC as well. Since unlink()
actually deletes a file, if that breaks because filesystem is full
you lost since you cannot free any space by removing files...

So fixing the tst_fill_fs() and doing the mkdir() before we start these
threads should IMHO fix the test.

-- 
Cyril Hrubis
chrubis@suse.cz
