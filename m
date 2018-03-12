From: Otto Ebeling <otto.ebeling@iki.fi>
Date: Mon, 12 Mar 2018 11:46:44 +0200 (EET)
Subject: [LTP] migrate_pages() of process with same UID in 4.15-rcX
In-Reply-To: <20180129135747.GG21609@dhcp22.suse.cz>
References: <1394749328.5225281.1515598510696.JavaMail.zimbra@redhat.com>
 <87d12hbs6s.fsf@xmission.com> <20180129133151.GF21609@dhcp22.suse.cz>
 <20180129135747.GG21609@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.11.1803121143440.19708@lakka.kapsi.fi>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

[sorry for the even later reply]

I don't have a strong preference either way (between fs creds or real 
creds), having the same behavior as proc_mem_open sounds like a sensible 
option too. Whether moving pages between NUMA nodes is a read-only 
(PTRACE_MODE_READ) activity is debatable, but I'm no NUMA expert.

My concern here was mainly about a) preventing layout discovery and b) 
consistency between move_pages and migrate_pages.

Otto



On Mon, 29 Jan 2018, Michal Hocko wrote:

> [Fixup Christoph email - the thread starts here
> http://lkml.kernel.org/r/1394749328.5225281.1515598510696.JavaMail.zimbra@redhat.com]
>
> On Mon 29-01-18 14:31:51, Michal Hocko wrote:
>> [Sorry for a very late reply]
>>
>> On Wed 10-01-18 10:21:31, Eric W. Biederman wrote:
>> [...]
>>> All of that said.  I am wondering if we should have used
>>> PTRACE_MODE_READ_FSCREDS on these permission checks.
>>
>> If this is really about preventing the layout discovery then we should
>> be in sync with proc_mem_open and that uses PTRACE_MODE_FSCREDS|PTRACE_MODE_READ
>> Should we do the same thing here?
>> --
>> Michal Hocko
>> SUSE Labs
>
> -- 
> Michal Hocko
> SUSE Labs
>
