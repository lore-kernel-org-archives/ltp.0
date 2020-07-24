From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 24 Jul 2020 14:47:44 +0200
Subject: [LTP] [PATCH] Convert chdir01 to the new API
In-Reply-To: <20200724123606.GA24626@dell5510>
References: <20200717152450.10787-1-mdoucha@suse.cz>
 <2b209b61-2bbc-c35f-5704-7b84bab9254d@cn.fujitsu.com>
 <20200723113317.GA18525@dell5510> <20200724080732.GA16478@yuki.lan>
 <20200724123606.GA24626@dell5510>
Message-ID: <9ec2de07-cad9-adef-8bd9-06abe2ae9777@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 24. 07. 20 14:36, Petr Vorel wrote:
>>> chdir02.c tests chdir("/"); and chdir("/tmp"). Not sure whether full path is
>>> more coverage than relative path from chdir01.c.
>>> If we consider these useful, we can just add it into chdir01.c.
> 
>>> Although it looks a bit strange to chroot into root, I'd use just that and avoid
>>> /tmp (it breaks at least for Android with no good reason).
> 
>> I guess that we can add /etc or something that is generally present on
>> the system.
> /etc is a symlink to /system/etc (maybe not presented everywhere). /sbin or /bin
> are symlinks on distros which has done usr merge, thus might disappear in the
> future.  I'd vote for /dev, which is everywhere (so far).

Note that we technically also have a test case for absolute path to LTP
working directory (changed to mountpoint in v2) because each test case
starts with SAFE_CHDIR(workdir);.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
