From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Jul 2020 15:26:50 +0200
Subject: [LTP] [PATCH] Convert chdir01 to the new API
In-Reply-To: <9ec2de07-cad9-adef-8bd9-06abe2ae9777@suse.cz>
References: <20200717152450.10787-1-mdoucha@suse.cz>
 <2b209b61-2bbc-c35f-5704-7b84bab9254d@cn.fujitsu.com>
 <20200723113317.GA18525@dell5510> <20200724080732.GA16478@yuki.lan>
 <20200724123606.GA24626@dell5510>
 <9ec2de07-cad9-adef-8bd9-06abe2ae9777@suse.cz>
Message-ID: <20200724132650.GG9768@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > /etc is a symlink to /system/etc (maybe not presented everywhere). /sbin or /bin
> > are symlinks on distros which has done usr merge, thus might disappear in the
> > future.  I'd vote for /dev, which is everywhere (so far).
> 
> Note that we technically also have a test case for absolute path to LTP
> working directory (changed to mountpoint in v2) because each test case
> starts with SAFE_CHDIR(workdir);.

Fair enough.

-- 
Cyril Hrubis
chrubis@suse.cz
