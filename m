From: Li Wang <liwang@redhat.com>
Date: Mon, 9 Nov 2020 17:23:30 +0800
Subject: [LTP] [PATCH] lib/tst_cgroup: fix short reads of mems/cpus
In-Reply-To: <CAEemH2dHXYbmkbzccWNurYURZQJJ4GENRBr=6KfQaL5HJaBO2g@mail.gmail.com>
References: <5d6e978c803e4e6449cabd89596729bfad996a17.1604408825.git.jstancek@redhat.com>
 <CAEemH2dHXYbmkbzccWNurYURZQJJ4GENRBr=6KfQaL5HJaBO2g@mail.gmail.com>
Message-ID: <CAEemH2f-okBCGktRfT5-RgkXziAu3FrFAN7Qih2vz=A9mfJzRw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 4, 2020 at 2:22 PM Li Wang <liwang@redhat.com> wrote:

> ...
>> -       tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "cpus", buf);
>> +       tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "cpus", buf,
>> sizeof(buf));
>>         tst_cgroup_cpuset_write_files(PATH_TMP_CG_CST, "cpus", buf);
>> -       tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "mems", mems);
>> +       tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "mems", mems,
>> sizeof(buf));
>>
>
> sizeof() is generally used to calculate the size (in bytes) of a data type,
> e.g sizeof(char *).
> I think here to pass 'BUFSIZ' directly is better than sizeof(buf).
>

Jan, do you agree with this point?
If yes, I can help to modify and apply this patch.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201109/b2c2e584/attachment.htm>
