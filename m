From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 Oct 2017 12:07:33 +0100
Subject: [LTP] [PATCH 08/18] creat08: ensure test directories are
 created in /tmp/
In-Reply-To: <20171026141447.26749-9-punit.agrawal@arm.com>
References: <20171026141447.26749-1-punit.agrawal@arm.com>
 <20171026141447.26749-9-punit.agrawal@arm.com>
Message-ID: <20171031110733.GF14550@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> runltp runs tests in the ${LTP_ROOT}/bin directory. If this is NFS
> mounted, we can run into problems that need to use setgid. Fix this by
> ensuring that creat08 creates directories in /tmp/

The test setup calls tst_tmpdir() which creates temporary directory in
/tmp/ and changes $PWD to point into it. So these directories has to be
created in /tmp/. If that is not the case something is wrong with the
test.

-- 
Cyril Hrubis
chrubis@suse.cz
