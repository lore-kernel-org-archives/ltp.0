From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 27 Sep 2018 18:52:39 +0300
Subject: [LTP] [PATCH v3] syscalls/fanotify11: new test for report
	thread id
In-Reply-To: <20180927144039.5345-1-nixiaoming@huawei.com>
References: <20180927144039.5345-1-nixiaoming@huawei.com>
Message-ID: <CAOQ4uxgoMxXnZgce=ry9M-skP2_NyQAKZGfnrj33BhFUEEJ5pg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 27, 2018 at 6:28 PM nixiaoming <nixiaoming@huawei.com> wrote:
>
> syscalls/fanotify11
> test fanotify_init with FAN_EVENT_INFO_TID
>         data->pid is ID(pid)  of the thread that caused the event
> test fanotify_init without FAN_EVENT_INFO_TID
>         data->pid is ID(tgid) of the process that caused the event
>
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> ---
>
> this is not testing an upstream feature, only RFC.

Nixiaoming,

This is very close to the test I wanted to see.
Now I have are a few more nits and some comments I made on
previous version that were probably not communicated
properly, so I rather take your test to my development tree
and make some small changes myself if you don't mind.

I do need one more legal thing from you is that you re-send the
patch with correct Copyright line, unless you intended to assign
copyright to SUSE...
Either ask your employer or copy from an existing LTP test
contributed from your employer and use the current year.

I will then post it along with FAN_FILESYSTEM_MARK test
if and when they get merged upstreamed and I will be do
the same with the man page update patches.

Thanks and good job!
Amir.
