From: Li Wang <liwang@redhat.com>
Date: Wed, 25 May 2016 14:17:40 +0800
Subject: [LTP] [PATCH v2 3/3] syscalls/madvise02: reconstruct and
 convert to new API
In-Reply-To: <20160523141418.GB25488@rei.lan>
References: <1463979557-21421-1-git-send-email-liwang@redhat.com>
 <20160523141418.GB25488@rei.lan>
Message-ID: <20160525061740.GB32546@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, May 23, 2016 at 04:14:18PM +0200, Cyril Hrubis wrote:
> 
> This whole part is a mess. You should not change the content of the
> structure in this way. If there are values that has to be changed on the
> runtime the structure members should be initialized with a pointers to a
> variable and that variable should be set up in the setup().

Good proposals, but this situation are a little bit different.

I failed to decrease the lines of this part. Since madvise02 catch
failures on purpose. It is very hard to divide 'Not Support' with
'Expected Errno' when getting EINVAL msg.

So, I'd like to keep calling a tcases_filter() in test function to
make the testcase working correctly. And move an enable flag as a
global variable.

Patch V3 is coming...

Regards,
Li Wang
