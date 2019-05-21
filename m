From: Sandeep Patil <sspatil@android.com>
Date: Tue, 21 May 2019 12:40:01 +0800
Subject: [LTP] [RFC PATCH 1/1] open_posix_testsuite/pthread_sigmask: fix
 return value checks
In-Reply-To: <20190520095356.GB25405@rei.lan>
References: <20190520041730.28238-1-sspatil@android.com>
 <20190520041730.28238-2-sspatil@android.com>
 <20190520095356.GB25405@rei.lan>
Message-ID: <20190521044001.GB7753@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, May 20, 2019 at 11:53:57AM +0200, Cyril Hrubis wrote:
> Hi!
> > Consistently use error(3) and replace all occurences of perror()
> > at the same time.
> 
> The error(3) is GNU extension we cannot use it in a POSIX testsuite as
> such, I guess that we will have to add custom error reporting functions
> (in a separate patch) to the open_posix_testsuite/include/posixtest.h
> header...
> 
> Other than that the patch is obviously correct.

Thanks you want me to add an error(3)-like function there?
I guess I can do that and then start changing all tests.

Thanks for pointing out the GNU-extension, didn't realize that.

- ssp
