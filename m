From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 Nov 2017 13:41:47 +0100
Subject: [LTP] Towards 4.14 LTS
In-Reply-To: <EF258C71-3F2A-449C-8283-EA4F715C81C0@linaro.org>
References: <5E1947BC-9D22-42EB-BA29-96EA15A9C817@linaro.org>
 <20171119112051.GA10015@kroah.com>
 <EF258C71-3F2A-449C-8283-EA4F715C81C0@linaro.org>
Message-ID: <20171121124147.GA10420@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> For instance 4.13-rc just was added to the mix.
> 
> For test buckets, I???m currently dorking around with some make check targets
> for a few interesting packages. 

You may want to look into xfstests as well, we found a few kernel oopses
recently related to backported FS patches for SLES kernels.

-- 
Cyril Hrubis
chrubis@suse.cz
