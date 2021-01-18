From: liuxp11@chinatelecom.cn <liuxp11@chinatelecom.cn>
Date: Mon, 18 Jan 2021 11:34:45 +0800
Subject: [LTP] [PATCH] fs/proc01.c:add known issues
References: <1610672031-5044-1-git-send-email-liuxp11@chinatelecom.cn>, 
 <95241263.33332311.1610722445185.JavaMail.zimbra@redhat.com>
Message-ID: <202101181134453606602@chinatelecom.cn>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

thanks for good question.

i check the source linux-source-5.8.0,in filesecurity/smack/smack_lsm.c:smack_getprocattr
directly return -EINVAL.

static int smack_getprocattr(struct task_struct *p, char *name, char **value)
{
        struct smack_known *skp = smk_of_task_struct(p);
        char *cp;
        int slen;

        if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
                return -EINVAL;

        cp = kstrdup(skp->smk_known, GFP_KERNEL);
        if (cp == NULL)
                return -ENOMEM;

        slen = strlen(cp);
        *value = cp;
        return slen;
}


 
From: Jan Stancek
Date: 2021-01-15 22:54
To: Xinpeng Liu
CC: ltp
Subject: Re: [LTP] [PATCH] fs/proc01.c:add known issues
 
----- Original Message -----
> Test in ubuntu20.10,there are several failure tests.
> 
> proc01      1  TFAIL  :  proc01.c:396: read failed:
> /proc/self/task/61595/attr/smack/current: errno=EINVAL(22): Invalid argument
> proc01      2  TFAIL  :  proc01.c:396: read failed:
> /proc/self/task/61595/attr/apparmor/prev: errno=EINVAL(22): Invalid argument
> proc01      3  TFAIL  :  proc01.c:396: read failed:
> /proc/self/task/61595/attr/apparmor/exec: errno=EINVAL(22): Invalid argument
> proc01      4  TFAIL  :  proc01.c:396: read failed:
> /proc/self/attr/smack/current: errno=EINVAL(22): Invalid argument
> proc01      5  TFAIL  :  proc01.c:396: read failed:
> /proc/self/attr/apparmor/prev: errno=EINVAL(22): Invalid argument
> proc01      6  TFAIL  :  proc01.c:396: read failed:
> /proc/self/attr/apparmor/exec: errno=EINVAL(22): Invalid argument
 
I'm OK with ignoring it, but commit log could explain more why we get EINVAL
on read here.
 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210118/c5aa8f84/attachment.htm>
