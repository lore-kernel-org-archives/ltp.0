From: Li Wang <liwang@redhat.com>
Date: Wed, 7 Nov 2018 22:34:46 +0800
Subject: [LTP] [PATCH 1/4] syscalls/migrate_pages02: convert to newlib
In-Reply-To: <4ab262666b5022a1f62a2e2967899dfecc56396d.1541431525.git.jstancek@redhat.com>
References: <4ab262666b5022a1f62a2e2967899dfecc56396d.1541431525.git.jstancek@redhat.com>
Message-ID: <CAEemH2fHHZ0-pVS+N7eVM6K8z=yTGhBHF1fKFOr516LyyyrZcQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Jan Stancek <jstancek@redhat.com> wrote:

>
>                 /* wait until child1 is ready on node1, then migrate and
>                  * signal to check current node */
> -               if (read(child1_ready[0], &tmp, 1) != 1)
> -                       tst_brkm(TBROK | TERRNO, NULL, "read #2 failed");
> +               TST_CHECKPOINT_WAIT(1);
>

Just curious why not start from 0? TST_CHECKPOINT_WAIT(0)

-       tst_record_childstatus(NULL, child2);
> -       tst_record_childstatus(NULL, child1);
> +       SAFE_WAITPID(child1, &status, 0);
> +       SAFE_WAITPID(child2, &status, 0);
>

Maybe we could set &wstatus as a NULL? we don't inspect the status
information after its children terminates so why we store it into &status?
Beside that two questions, patch set looks good to me.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181107/fc88417f/attachment.html>
