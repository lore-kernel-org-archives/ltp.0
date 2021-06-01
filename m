From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 1 Jun 2021 11:03:50 +0200
Subject: [LTP] [PATCH 1/2] network/busy_poll: Fix tests in namespaced env
In-Reply-To: <YLX3Qyah6SLQTKzW@pevik>
References: <20210531135314.5067-1-mdoucha@suse.cz>
 <f8300887-b372-950e-5c26-92ba36869246@bell-sw.com> <YLX3Qyah6SLQTKzW@pevik>
Message-ID: <03481451-41a5-7dc0-c675-fa622c7bcd6b@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01. 06. 21 11:00, Petr Vorel wrote:
>> Here should be net.core.busy_poll, not the path.
> Hi Alexey, Martin,
> 
> Yep, I was just going to report it as well.
> 
> Merging both patches with this fix, thanks both for your time!

Sorry about that and thanks for the fix.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
