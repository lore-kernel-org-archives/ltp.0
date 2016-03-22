From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Mar 2016 15:28:42 +0100
Subject: [LTP] max_map_count fail in arm64 system which support lib32
In-Reply-To: <56F14D59.1040701@huawei.com>
References: <56DD6138.9060109@huawei.com> <20160322102943.GA10195@rei.suse.cz>
 <56F14D59.1040701@huawei.com>
Message-ID: <20160322142842.GE10905@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I add a print:
> 
> #elif defined(__arm__)
> if (!strncmp(line, "ffff0000-ffff1000", 17))
>         {
>                 printf("%s\n", line);  // I add
>                 return true;
>         }
> 
> and then run it(32bit SDK):

...

> So I think:
> * arm 64bit kernel doesn't have 'special vma VSYSCALL' so no need to skip(32bit binary skip so fail);
> * arm 32bit kernel have 'special vma VSYSCALL';

That is what I think as well.

If you look at the code it does #if defined(__arm__) which is true if
you compile for 32bit arm, on 64bit __aarch64__ is defined instead.

Which is why I said we should do runtime check using the machine from
uname(2) on arm in order to skip the check in case that 32bit arm binary
runs on 64bit kernel. It should contain something as armvX on 32bit arm
and aarch64 on 64bit.

-- 
Cyril Hrubis
chrubis@suse.cz
