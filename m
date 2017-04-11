From: Zorro Lang <zlang@redhat.com>
Date: Tue, 11 Apr 2017 21:17:08 +0800
Subject: [LTP] [PATCH v3] lseek: functional SEEK_HOLE and SEEK_DATA test
In-Reply-To: <20170411124835.GA3738@rei.lan>
References: <1491662411-7720-1-git-send-email-zlang@redhat.com>
 <20170411124835.GA3738@rei.lan>
Message-ID: <20170411131708.GA5081@dhcp12-143.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 11, 2017 at 02:48:35PM +0200, Cyril Hrubis wrote:
> Hi!
> Pushed with minor changes, thanks.
> 
> I've added a lapi/seek.h header with fallback defintion for
> SEEK_DATA and SEEK_HOLE, dropped the ifdefs from the test, and added a
> a check if SEEK_HOLE is implemented to the test setup() function.
> 
> And also removed a few backslashes from the tst_res(... lines since
> these are not needed at all.

Thanks for doing this :)

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
