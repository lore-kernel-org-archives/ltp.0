From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 May 2019 11:53:57 +0200
Subject: [LTP] [RFC PATCH 1/1] open_posix_testsuite/pthread_sigmask: fix
 return value checks
In-Reply-To: <20190520041730.28238-2-sspatil@android.com>
References: <20190520041730.28238-1-sspatil@android.com>
 <20190520041730.28238-2-sspatil@android.com>
Message-ID: <20190520095356.GB25405@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Consistently use error(3) and replace all occurences of perror()
> at the same time.

The error(3) is GNU extension we cannot use it in a POSIX testsuite as
such, I guess that we will have to add custom error reporting functions
(in a separate patch) to the open_posix_testsuite/include/posixtest.h
header...

Other than that the patch is obviously correct.

-- 
Cyril Hrubis
chrubis@suse.cz
