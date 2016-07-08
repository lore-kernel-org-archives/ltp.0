From: Hoang Thi Thuy Nga (RBVH/ENG2) <Nga.HoangThiThuy@vn.bosch.com>
Date: Fri, 8 Jul 2016 09:24:44 +0000
Subject: [LTP] updating message_queue_test_02_*
In-Reply-To: <577E535F.2040606@de.bosch.com>
References: <577E4340.4060208@de.bosch.com> <577E535F.2040606@de.bosch.com>
Message-ID: <c5da00d5b67d484d9c8b23ede1b3746f@SGPMBX1022.APAC.bosch.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Oleksij,

Some observations from our side:
-       In other to run message_queue_test_02_snd, message_queue_test_02_rcv, message_queue_test_02_ctl successfully, we need to run message_queue_test_02_get before.
 Because message_queue_test_02_get will create file /tmp/message_queue_test as well as create generate message queue identifier which will be used in the other three.
-       message_queue_test_02_snd, message_queue_test_02_rcv, message_queue_test_02_ctl doesn’t work with –f to specify another location for project name in case the message queue identifier not yet generated along with the file

message_queue_test_02_get.c

         int main(int argc, char **argv),
{
        key_t key;              /* Unique key */
        int msqid;              /* Message queue identifier */
        int fd;                 /* Temp file descriptor */
        mode_t mode = 0777;     /* Default mode bits */

        /*
         * Parse command line options
         */
        parse_args(argc, argv);

        if ((fd = open(project_name, O_CREAT | O_RDWR, mode)) < 0)
                sys_error("open failed", __LINE__);

        if (close(fd) < 0)
                sys_error("close failed", __LINE__);

        if ((key = ftok(project_name, project_id)) < 0)
                sys_error("ftok failed", __LINE__);

        if ((msqid = msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR)) < 0)
                sys_error("msgget failed", __LINE__);

        printf("%d\n", msqid);

        return (0);
}


Trân trọng / Best regards

Nga Hoang Thi Thuy
RBVH/ENG2

Tel. +49(711)8113624527



-----Original Message-----
From: FIXED-TERM Rempel Oleksij (CM/ESO3)
Sent: Thursday, July 07, 2016 8:05 PM
To: ltp@lists.linux.it; Le Cong Binh (RBVH/ENG2) <Binh.LeCong@vn.bosch.com>; Hoang Thi Thuy Nga (RBVH/ENG2) <Nga.HoangThiThuy@vn.bosch.com>
Subject: Re: [LTP] updating message_queue_test_02_*

On 07.07.2016 13:55, fixed-term.Oleksij.Rempel wrote:
> Hallo all,
>
> it is kind of a duplication of this case:
> https://github.com/linux-test-project/ltp/issues/75
>
> some of message_queue_test_02_* are fail on our configuration, it looks
> like the reason is hardcoded tmp path, which is different in our test setup.
>
> Looks like this tests should be updated to use current ltp bindings..
> which should also fix this issue.  Do any one already working on it? If
> not, me or some of us will try to do it.
>

hm...
to execute *message_queue_test_02_rcv* properly, first should be
*message_queue_test_02_snd* executed. And most important, target should
not be reseted after message_queue_test_02_snd. If this happens,
message_queue_test_02_rcv will hang forever.
It is not looks like proper behaviour (it is not theoretical assumption.).

May be message_queue_test_02_rcv should be wrapped by a script which
will start rcv in background and then send after short sleep?
And some how make sure that message_queue_test_02_rcv wont wait forever?

Any comments?

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160708/3bed48f4/attachment.html>
