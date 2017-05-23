From: Rajesh <rajeshkuri@gmail.com>
Date: Tue, 23 May 2017 15:08:30 +0530
Subject: [LTP] ltp-pan failing
In-Reply-To: <20170515144828.GA17237@rei.suse.de>
References: <CALp+=PD4_zLu_ctpaZuTgWHsq3q90RKn_wYuBXS8c=-G+FYfQw@mail.gmail.com>
 <20170515144828.GA17237@rei.suse.de>
Message-ID: <CALp+=PBk_j_TeiOACfDZdfmKP5bkXOQrOFk7swYXc35TvM31jQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thank you for the reply.

The problem was to do with code change I made in ltp-pan.c, to use
vfork() instead of fork().

The child process was closing the active file descriptor and hence
when parent try to access the file descriptor hitting with "Bad file
descriptor".
Issue was fixed by commenting out the statement in child code.

--Regards,
rajesh

On Mon, May 15, 2017 at 8:19 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> I'm trying to run the LTP in embedded environment. (Having ramdisk as
>> files system and n/w shared directory for file storage)
>> The LTP version is ''ltp-full-20120401'' and ran simple command as below:
>> # ./ltp-pan -n exp1  -a /tmp/test -x 3 echo hello
>> And above command failed as:
>> "pan(exp1): failed to unlock zoo file, errno:9 Bad file descriptor"
>
> That looks like a problem with possibly unsupported file fcntl() locks on /tmp/test.
>
>> Are there any specific configuration to run LTP in embedded environment?
>
> There shouldn't be any.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
