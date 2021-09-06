From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Sep 2021 10:12:12 +0200
Subject: [LTP] [xattr]  6e21a50861: ltp.setxattr02.fail
In-Reply-To: <20210905134541.GD15026@xsang-OptiPlex-9020>
References: <20210905134541.GD15026@xsang-OptiPlex-9020>
Message-ID: <YTXNXOKbrl17Lx+s@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> commit: 6e21a5086100cebefd21a3058a9e1160668f84fa ("xattr: Allow user.* xattr on symlink and special files")
> https://github.com/rhvgoyal/linux user-xattr-symlink-v3

The test that fails is a test that asserts that you can't add extended
attributes to a block or char device and it's obvious why this fails.

Feel free to ignore this failure, we will have to fix the tests once/if
this patchset gets accepted upstream.

-- 
Cyril Hrubis
chrubis@suse.cz
