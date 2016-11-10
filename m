From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Nov 2016 12:39:02 +0100
Subject: [LTP] [PATCH] lsmod01: keep the output in variables
In-Reply-To: <582446EB.2080206@oracle.com>
References: <20161011161557.GD17083@rei.suse.cz>
 <1478702093-15080-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20161109164956.GB9168@rei.lan> <582446EB.2080206@oracle.com>
Message-ID: <20161110113902.GB11677@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Hmm since the foo=$() flattened the text into single line this diff
> > would be pretty much useless.
> 
> Sorry, but are you sure about that?
> 
> [stas@kholmanskikh ~]$ lsmod_output=$(lsmod | awk '!/Module/{print $1,
> $2, $3}' | sort)
> [stas@kholmanskikh ~]$ echo "$lsmod_output" > /tmp/gg
> [stas@kholmanskikh ~]$ tail -n 2 /tmp/gg
> xt_state 1370 3
> zlib_deflate 21991 1
> [stas@kholmanskikh ~]$ modules_output=$(awk '{print $1, $2, $3}'
> /proc/modules | sort)
> [stas@kholmanskikh ~]$ echo "$modules_output" > /tmp/zz
> [stas@kholmanskikh ~]$ tail -n 2 /tmp/zz
> xt_state 1370 3
> zlib_deflate 21991 1
> [stas@kholmanskikh ~]$
> 
> i.e. the content of /tmp/gg and /tmp/zz are in the form ready to be diff-ed.

You are right, the double quotes makes the difference here.

$ modules_output=$(awk '{print $1, $2, $3}' /proc/modules | sort)

$ echo $modules_output
bluetooth 320499 5 btbcm 5506 1 btintel 2739 1 ...

$ echo "$modules_output"
bluetooth 320499 5
btbcm 5506 1
btintel 2739 1
...


Consider the patch acked then.

-- 
Cyril Hrubis
chrubis@suse.cz
