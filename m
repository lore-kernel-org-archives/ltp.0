From: liuxp11@chinatelecom.cn <liuxp11@chinatelecom.cn>
Date: Mon, 18 Jan 2021 19:35:51 +0800
Subject: [LTP] [PATCH] fs/proc01.c:add known issues
References: <1610672031-5044-1-git-send-email-liuxp11@chinatelecom.cn>, 
 <95241263.33332311.1610722445185.JavaMail.zimbra@redhat.com>, 
 <202101181134453606602@chinatelecom.cn>, 
 <830441383.33482781.1610967897529.JavaMail.zimbra@redhat.com>
Message-ID: <2021011819355121464612@chinatelecom.cn>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Right, smack is disabled in my system, and enabled appamor.

static int apparmor_getprocattr(struct task_struct *task, char *name,
                                char **value)
{
        int error = -ENOENT;
        /* released below */
        const struct cred *cred = get_task_cred(task);
        struct aa_task_ctx *ctx = task_ctx(current);
        struct aa_label *label = NULL;
        bool newline = true;

        if (strcmp(name, "current") == 0)
                label = aa_get_newest_label(cred_label(cred));
        else if (strcmp(name, "prev") == 0  && ctx->previous)   //HERE ctx->previous == NULL then return -EINVAL;
                label = aa_get_newest_label(ctx->previous);
        else if (strcmp(name, "exec") == 0 && ctx->onexec)    //HERE ctx->onexec == NULL then return -EINVAL;
                label = aa_get_newest_label(ctx->onexec);
        else if (strcmp(name, "context") == 0) {
                label = aa_get_newest_label(cred_label(cred));
                newline = false;
        } else
                error = -EINVAL;

        if (label)
                error = aa_getprocattr(label, value, newline);

        aa_put_label(label);
        put_cred(cred);

        return error;
}

thanks for your direction.

 
From: Jan Stancek
Date: 2021-01-18 19:04
To: liuxp11
CC: ltp; lkml
Subject: Re: [LTP] [PATCH] fs/proc01.c:add known issues



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

That doesn't look correct, strcmp when reading "current" returns 0, so you condition above
shouldn't be hit.

I'm guessing you don't have smack enabled, and EINVAL is the default LSM ret value
in such case:

LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, char *name,
         char **value)

int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
                                char **value)
{
        struct security_hook_list *hp;

        hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
                if (lsm != NULL && strcmp(lsm, hp->lsm))
                        continue;
                return hp->hook.getprocattr(p, name, value);
        }
        return LSM_RET_DEFAULT(getprocattr);
}


        cp = kstrdup(skp->smk_known, GFP_KERNEL);
        if (cp == NULL)
                return -ENOMEM;

        slen = strlen(cp);
        *value = cp;
        return slen;
}


From:Jan Stancek
Date: 2021-01-15 22:54
To:Xinpeng Liu
CC:ltp
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
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210118/a495618f/attachment-0001.htm>
