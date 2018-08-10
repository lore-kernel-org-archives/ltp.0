From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 10 Aug 2018 14:50:16 +0200
Subject: [LTP] [PATCH v2] syscalls/fsetxattr02.c: Fix the failure of
 opening device files
In-Reply-To: <1533795985-26787-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180809145723.5e6s3okx6rci2qdj@mobile.celeiro.br>
 <1533795985-26787-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180810125016.GB32275@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We try to fix this issue by creating device files in /dev/ instead.

I do not like much that we are messing up with the system directories.

Maybe we could mount a tmpfs over a directory in the test temporary
directory if we detect that the test temporary directory is mounted
with nodev. The downsinde is that it will be a bit more complicated
than this solution.

-- 
Cyril Hrubis
chrubis@suse.cz
