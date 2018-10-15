From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 15 Oct 2018 15:35:11 +0300
Subject: [LTP] [PATCH V2 1/5] Remove the pipes runtest file
In-Reply-To: <20181012151656.GD5080@rei>
References: <1539349857-10633-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20181012151656.GD5080@rei>
Message-ID: <0294e94b-9e98-80b4-59f2-77c83e0fdb32@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi.

On 10/12/2018 06:16 PM, Cyril Hrubis wrote:
> Hi!
> The whole patchset looks good to me.
> 

Thank you. I committed the series.

Sadly, but I missed that 'git am' was not happy with the description
message for the first patch, so now it looks like:

commit b8c9b0d326ef54f484cfe22878bc8df4304cfb5e
Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date:   Mon Oct 8 12:12:43 2018 +0300

    Remove the pipes runtest file

    We have two almost identical runtest files:

    [root@localhost runtest]# diff ipc pipes
    1c1
    < #DESCRIPTION:Interprocess communication stress


i.e. the description is truncated, and Signed-off-by and Acked-by lines
are gone too.

I'm sorry about that.
