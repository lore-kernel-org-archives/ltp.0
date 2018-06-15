From: Li Wang <liwang@redhat.com>
Date: Fri, 15 Jun 2018 16:16:13 +0800
Subject: [LTP] [PATCH v2] open08: rewrite to newlib
In-Reply-To: <334996146.26786343.1529043115414.JavaMail.zimbra@redhat.com>
References: <787996724f38cfa88d0a8c9a0a713d056ba01307.1528980323.git.jstancek@redhat.com>
 <CAEemH2dFRruWBBU+p5qU5vtGxc-ibjbFpW5TjNd=P0G=7TALfA@mail.gmail.com>
 <CAEemH2eLzFsjx=3yhP-qN6=P=3DwJ9txR_0TfE2iYUhB7qiXoQ@mail.gmail.com>
 <334996146.26786343.1529043115414.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2fi7AieoSP7kAusuTjR81kab1CFgfiGerVwZyngNDPYLA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jun 15, 2018 at 2:11 PM, Jan Stancek <jstancek@redhat.com> wrote:
>
>>  void verify_open(unsigned int i)
>>  {
>> -    if (tcases[i].setup)
>> -        tcases[i].setup(&tcases[i]);
>> +    if (i == ARRAY_SIZE(tcases) - 1) {
>
> It's same as hardcoding index to array - if someone adds
> new testcase it breaks.

Yes, to avoid that, new testcase should not be as the last one.

>
> But we could set it to some special value (NULL) and check all cases against that.
> If it's NULL, then make a bad_addr.

Agreed.

-- 
Regards,
Li Wang
