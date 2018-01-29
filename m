From: Michal Hocko <mhocko@suse.com>
Date: Mon, 29 Jan 2018 14:57:47 +0100
Subject: [LTP] migrate_pages() of process with same UID in 4.15-rcX
In-Reply-To: <20180129133151.GF21609@dhcp22.suse.cz>
References: <1394749328.5225281.1515598510696.JavaMail.zimbra@redhat.com>
 <87d12hbs6s.fsf@xmission.com>
 <20180129133151.GF21609@dhcp22.suse.cz>
Message-ID: <20180129135747.GG21609@dhcp22.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

[Fixup Christoph email - the thread starts here
 http://lkml.kernel.org/r/1394749328.5225281.1515598510696.JavaMail.zimbra@redhat.com]

On Mon 29-01-18 14:31:51, Michal Hocko wrote:
> [Sorry for a very late reply]
> 
> On Wed 10-01-18 10:21:31, Eric W. Biederman wrote:
> [...]
> > All of that said.  I am wondering if we should have used
> > PTRACE_MODE_READ_FSCREDS on these permission checks.
> 
> If this is really about preventing the layout discovery then we should
> be in sync with proc_mem_open and that uses PTRACE_MODE_FSCREDS|PTRACE_MODE_READ
> Should we do the same thing here?
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
