From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 28 Sep 2020 10:00:10 +0100
Subject: [LTP] [RFC][PATCH] tst_cgroup: Attempt to use CGroups V2 then
 V1 instead of guessing
In-Reply-To: <CAEemH2eo6qVt0D36QVDFeW_2csWFEDnnghxRjd3_Ysu=CD-8Hw@mail.gmail.com>
References: <20200925121941.10475-1-rpalethorpe@suse.com>
 <CAEemH2eo6qVt0D36QVDFeW_2csWFEDnnghxRjd3_Ysu=CD-8Hw@mail.gmail.com>
Message-ID: <87y2kuwa1x.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li,

Li Wang <liwang@redhat.com> writes:

>>
>> -static void tst_cgroup2_mount(const char *mnt_path, const char *new_path)
>> +static int cgroup2_mount(const char *mnt_path, const char *new_path)
>>
>
> We'd like to make the series function name starts with tst_*.
>

The idea is this will be an internal/static function and
tst_cgroup2_mount will be a public function if it is needed. I guess
that eventually there will be features only available in cgroup2, in
which case the test author will want to call tst_cgroup2_mount not
tst_cgroup_mount and they will just want it to fail with tst_brk if
cgroup2 can't be mounted.

Infact, if the user wants cpuset or some other V1 only controller, then
they should probably call tst_cgroup1_mount. AFAICT some of these
controllers will not be moved to V2. OTOH a functionally similar feature
may be available in V2, but with a different interface. There is a
difference between requiring a specific controller to test it and
needing some functionality without caring how it is provided.

So I suggest providing an API for mounting specific cgroup versions and
controllers and an API to mount specific controllers of either version
(i.e. tst_cgroup_mount). Then we can create helper functions to provide
functionality without caring how it is achieved, if we need to do that.

Other comments sound good! I will try creating another patch with
diagnostics.

-- 
Thank you,
Richard.
