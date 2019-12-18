From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 18 Dec 2019 12:03:44 +0100
Subject: [LTP] [PATCH] isofs: Convert to new library
In-Reply-To: <20191218105920.GB26489@dell5510>
References: <20191209093659.31996-1-lkml@jv-coder.de>
 <20191218103927.GA26489@dell5510> <20191218105920.GB26489@dell5510>
Message-ID: <3b6c187d-7e72-8d9a-ae42-189bedc3098d@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

thanks for merging
>> You correctly removed getopt options: -n just set NO_CLEANUP, which is not used
>> any more on test.sh. Both libraries support TST_NO_CLEANUP, so we should
>> document it (going to send a patch).
> In the end I just merged that simple doc change.
> I wonder if there would be use for variable keeping $TST_TMPDIR (because it's
> deleted even with $TST_NO_CLEANUP).
I think that was the reason why I completely removed the flag in the 
first place.
Also I did not see any reason to keep the tempdir. If I ever needed this 
in the past, I just modified the test.

J?rg
