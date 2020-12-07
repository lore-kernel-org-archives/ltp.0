From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Dec 2020 16:07:02 +0200
Subject: [LTP] [PATCH 3/5] syscalls/fanotify09: Read variable length
 events
In-Reply-To: <X84VqaD4+FqAix5h@pevik>
References: <20201204095930.866421-1-amir73il@gmail.com>
 <20201204095930.866421-4-amir73il@gmail.com>
 <X84VqaD4+FqAix5h@pevik>
Message-ID: <CAOQ4uxiCtAJVyVau3un2AnMNmn1Yub18sG10YopLRySmLAcpnw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Dec 7, 2020 at 1:44 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir,
>
> > In preparation of testing events with filename info, teach the
> > how to read variable length events and parse the name info.
>
> This commit broke umount() on old kernels. (LTP lib doing multiple attempts is
> useless here). Not sure what exactly is being used, it's not by staing in
> mounted directory. Any idea how to fix it?
>

--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -265,6 +265,7 @@ static void test_fanotify(unsigned int n)
        for (i = 1; i < NUM_GROUPS; i++) {
                ret = read(fd_notify[i], event_buf, FAN_EVENT_METADATA_LEN);
                if (ret > 0) {
+                       event = (struct fanotify_event_metadata *)event_buf;
                        event_res(TFAIL, i, event, "");
                        if (event->fd != FAN_NOFD)
                                SAFE_CLOSE(event->fd);

The fix exists in the following patch, therefore I did not notice the
mid series regression.

Thanks,
Amir.
