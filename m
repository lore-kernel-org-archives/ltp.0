From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 3 Jun 2020 12:43:15 +0200
Subject: [LTP] [PATCH v2 1/4] lib: add new cgroup test API
In-Reply-To: <CAEemH2d7OzG6jBZ15bYGRHm7ry-gVjzuwJYhbHp3yitB3_928w@mail.gmail.com>
References: <20200601100459.32511-1-liwang@redhat.com>
 <1365679659.14324910.1591019831545.JavaMail.zimbra@redhat.com>
 <CAEemH2ffNHY6Ej-Er5a4Ng_9zw+RX+wEBc0widntmYqDLNRqxw@mail.gmail.com>
 <20200602121232.GA22599@janakin.usersys.redhat.com>
 <CAEemH2d7OzG6jBZ15bYGRHm7ry-gVjzuwJYhbHp3yitB3_928w@mail.gmail.com>
Message-ID: <20200603104314.GA12583@janakin.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

>> >And the worth to say, the random directory name for same cgroup
>> >mounting is also on purpose, though we mount same(i.e memory)
>> >cgroup in two places it still belongs to the one hierarchy, and create
>> >the same name of the new directory will be hit an error in EEXIST.
>> >
>> >static void tst_cgroup_set_path(const char *cgroup_dir)
>> >{
>> >    ...
>> >    sprintf(tst_cgroup_mnt_path, "%s", cgroup_dir);
>> >    sprintf(tst_cgroup_new_path, "%s/ltp_%d", cgroup_dir, rand());
>>
>> I see why you are tracking this in list, but this exchange of state through
>> global variables does seem bit unclear.
>>
>
>Yes, that's a compromise to support more usage of the APIs.

I don't get why global variables are necessary.
tst_cgroup_mnt_path is always same as cgroup_dir parameter passed to all functions.
tst_cgroup_get_path() could return pointer to tst_cgroup_pathes->new_path,
  (you just need you call umount before del_path)
tst_cgroup_ctl_knob is set before each use, so it could be local variable too.

>I have no strong preference to shift from v2 to this method, or maybe we
>can try
>to combine together and do more optimize work in the lib side.

Sounds like we could use 3rd opinion.

