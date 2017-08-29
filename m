From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 29 Aug 2017 14:08:53 +0200
Subject: [LTP] [PATCH] android: access02: fix the executable shell path
In-Reply-To: <20170828223100.66766-1-sspatil@google.com>
References: <20170828223100.66766-1-sspatil@google.com>
Message-ID: <20170829120853.GF31839@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The test generated script used the hardcoded "/bin/sh" shell path
> that doesn't exist on Android system. So fix that by using
> "_PATH_BSHELL" variable defined in paths.h for both bionic and glibc.

I checked that the header is defined on musl libc as well and pushed,
thanks.

BTW: There is _PATH_TMP defined in that header as well, is that one present
     on android as well? If so and if it's pointing to something
     sensible we could have used that one in the getcwd test...

-- 
Cyril Hrubis
chrubis@suse.cz
