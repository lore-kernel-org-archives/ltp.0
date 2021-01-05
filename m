From: Radoslav Kolev <radoslav.kolev@suse.com>
Date: Tue, 05 Jan 2021 14:04:39 +0200
Subject: [LTP] [PATCH] cpio_tests.sh: Fix failure with BusyBox cpio
In-Reply-To: <X/RJhbNBfja6/Snr@pevik>
References: <20201221110120.26165-1-radoslav.kolev@suse.com>
 <20201222171033.GB126602@pevik> <X/RJhbNBfja6/Snr@pevik>
Message-ID: <beaad85cf7eb0f7c5e80f35f34e348b5abb03d98.camel@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi Petr, 

On Tue, 2021-01-05 at 12:12 +0100, Petr Vorel wrote:
> Thanks for your fix, merged with these changes:
> 
> * grep for BusyBox because some older versions does not contain the
> hint, but actually require it.
> 
> * move things to setup function due my following commit, which cannot
> be
> outside API functions (setup/test function):
> And check for -o (which is on BusyBox optional).

Thanks a lot for the review and fixes!


